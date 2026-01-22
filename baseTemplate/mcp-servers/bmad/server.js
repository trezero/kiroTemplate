#!/usr/bin/env node

const { Server } = require('@modelcontextprotocol/sdk/server/index.js');
const { StdioServerTransport } = require('@modelcontextprotocol/sdk/server/stdio.js');
const { CallToolRequestSchema, ListToolsRequestSchema } = require('@modelcontextprotocol/sdk/types.js');
const fs = require('fs');
const path = require('path');
const csv = require('csv-parser');

const BMAD_ROOT = process.env.BMAD_ROOT || path.join(process.cwd(), '_bmad');

class BmadMCPServer {
  constructor() {
    this.server = new Server(
      {
        name: 'bmad-mcp-server',
        version: '1.0.0',
      },
      {
        capabilities: {
          tools: {},
        },
      }
    );

    this.agents = new Map();
    this.setupToolHandlers();
    this.loadAgents();
  }

  async loadAgents() {
    try {
      const manifestPath = path.join(BMAD_ROOT, '_config', 'agent-manifest.csv');
      if (!fs.existsSync(manifestPath)) {
        console.error('Agent manifest not found:', manifestPath);
        return;
      }

      const agents = [];
      fs.createReadStream(manifestPath)
        .pipe(csv())
        .on('data', (row) => {
          agents.push({
            name: row.name,
            displayName: row.displayName,
            title: row.title,
            icon: row.icon,
            role: row.role,
            identity: row.identity,
            communicationStyle: row.communicationStyle,
            principles: row.principles,
            module: row.module,
            path: row.path
          });
        })
        .on('end', () => {
          agents.forEach(agent => {
            this.agents.set(agent.name, agent);
          });
          console.error(`Loaded ${agents.length} bmad agents`);
        });
    } catch (error) {
      console.error('Error loading agents:', error);
    }
  }

  setupToolHandlers() {
    this.server.setRequestHandler(ListToolsRequestSchema, async () => {
      const tools = [];
      
      // Add agent tools
      for (const [name, agent] of this.agents) {
        tools.push({
          name: `bmad_${name}`,
          description: `${agent.title}: ${agent.role}. ${agent.identity}`,
          inputSchema: {
            type: 'object',
            properties: {
              query: {
                type: 'string',
                description: 'Your request or question for this agent'
              }
            },
            required: ['query']
          }
        });
      }

      // Add utility tools
      tools.push({
        name: 'bmad_list_agents',
        description: 'List all available bmad agents with their capabilities',
        inputSchema: {
          type: 'object',
          properties: {},
          required: []
        }
      });

      return { tools };
    });

    this.server.setRequestHandler(CallToolRequestSchema, async (request) => {
      const { name, arguments: args } = request.params;

      if (name === 'bmad_list_agents') {
        const agentList = Array.from(this.agents.values()).map(agent => ({
          name: agent.name,
          displayName: agent.displayName,
          title: agent.title,
          icon: agent.icon,
          role: agent.role,
          module: agent.module
        }));
        
        return {
          content: [{
            type: 'text',
            text: JSON.stringify(agentList, null, 2)
          }]
        };
      }

      if (name.startsWith('bmad_')) {
        const agentName = name.replace('bmad_', '');
        const agent = this.agents.get(agentName);
        
        if (!agent) {
          throw new Error(`Agent ${agentName} not found`);
        }

        // Load agent content
        const agentPath = path.join(BMAD_ROOT, agent.path);
        let agentContent = '';
        
        if (fs.existsSync(agentPath)) {
          agentContent = fs.readFileSync(agentPath, 'utf8');
        }

        const response = `# ${agent.displayName} ${agent.icon}

**Role:** ${agent.role}
**Identity:** ${agent.identity}
**Communication Style:** ${agent.communicationStyle}
**Principles:** ${agent.principles}

## Your Query
${args.query}

## Agent Instructions
${agentContent}

---
*This is a bmad agent response. The agent should now respond according to their persona and capabilities.*`;

        return {
          content: [{
            type: 'text',
            text: response
          }]
        };
      }

      throw new Error(`Unknown tool: ${name}`);
    });
  }

  async run() {
    const transport = new StdioServerTransport();
    await this.server.connect(transport);
    console.error('Bmad MCP server running on stdio');
  }
}

const server = new BmadMCPServer();
server.run().catch(console.error);

# Database Query Agent

## Purpose
Execute PostgreSQL queries with formatted results for data analysis.

## Usage
- Run complex database queries
- Format results for readability
- Provide user-friendly data summaries

## Example
```sql
SELECT user_id, COUNT(*) as task_count 
FROM tasks 
GROUP BY user_id 
ORDER BY task_count DESC;
```

## Output Format
- Table format for structured data
- Summary statistics when relevant
- User-friendly column names
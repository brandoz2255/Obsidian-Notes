```txt
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { ScrollArea } from "@/components/ui/scroll-area"

export default function LogsPage() {
  // Sample log data
  const logs = [
    { id: 1, timestamp: "2025-03-17 15:32:14", level: "info", message: "System startup complete", source: "system" },
    {
      id: 2,
      timestamp: "2025-03-17 15:33:22",
      level: "warning",
      message: "High memory usage detected",
      source: "monitor",
    },
    {
      id: 3,
      timestamp: "2025-03-17 15:34:45",
      level: "error",
      message: "Failed to connect to remote server",
      source: "network",
    },
    {
      id: 4,
      timestamp: "2025-03-17 15:35:12",
      level: "info",
      message: "User authentication successful",
      source: "auth",
    },
    {
      id: 5,
      timestamp: "2025-03-17 15:36:30",
      level: "debug",
      message: "Processing queue items: 42 remaining",
      source: "queue",
    },
    {
      id: 6,
      timestamp: "2025-03-17 15:37:18",
      level: "info",
      message: "Scheduled maintenance starting in 30 minutes",
      source: "scheduler",
    },
    {
      id: 7,
      timestamp: "2025-03-17 15:38:05",
      level: "warning",
      message: "API rate limit approaching threshold",
      source: "api",
    },
    {
      id: 8,
      timestamp: "2025-03-17 15:39:27",
      level: "error",
      message: "Database query timeout after 30s",
      source: "database",
    },
    {
      id: 9,
      timestamp: "2025-03-17 15:40:11",
      level: "info",
      message: "Cache refresh completed successfully",
      source: "cache",
    },
    {
      id: 10,
      timestamp: "2025-03-17 15:41:33",
      level: "debug",
      message: "Request payload validation passed",
      source: "validator",
    },
  ]

  const getLevelColor = (level: string) => {
    switch (level) {
      case "error":
        return "bg-destructive text-destructive-foreground"
      case "warning":
        return "bg-warning text-warning-foreground"
      case "info":
        return "bg-primary text-primary-foreground"
      case "debug":
        return "bg-muted text-muted-foreground"
      default:
        return "bg-secondary text-secondary-foreground"
    }
  }

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold tracking-tight">System Logs</h1>
        <p className="text-muted-foreground">View and analyze system activity logs</p>
      </div>

      <Card className="border-gray-800/40 bg-card/30 backdrop-blur-sm">
        <CardHeader className="pb-3">
          <CardTitle>Log Events</CardTitle>
          <CardDescription>Showing the most recent system events and notifications</CardDescription>
        </CardHeader>
        <CardContent>
          <ScrollArea className="h-[60vh] pr-4">
            <div className="space-y-4">
              {logs.map((log) => (
                <div
                  key={log.id}
                  className="flex flex-col space-y-2 rounded-lg border border-gray-800/40 bg-background/50 p-4 shadow-sm transition-all hover:bg-background/80"
                >
                  <div className="flex items-center justify-between">
                    <Badge variant="outline" className="font-mono text-xs">
                      {log.timestamp}
                    </Badge>
                    <Badge className={`${getLevelColor(log.level)}`}>{log.level.toUpperCase()}</Badge>
                  </div>
                  <div className="font-mono text-sm">{log.message}</div>
                  <div className="text-xs text-muted-foreground">Source: {log.source}</div>
                </div>
              ))}
            </div>
          </ScrollArea>
        </CardContent>
      </Card>
    </div>
  )
}
``` this page i want to modify so that the logs which i beleive are in json correct if my wrong and let that be the first thing you do I need to document this correctly but where its showing the llogs data I need my python backend to do this instead im using flask but how can i modify the page to do that 

class Solution
{
	private:
	
	vector<string> ans;
	map< string, set<string> > graph;

	void dfs(string v)
	{
		while (!graph[v].empty())
		{
			string u = *graph[v].begin();
			graph[v].erase(graph[v].begin());
			dfs(u);
		}
		ans.push_back(v);
	}

	public:

	vector<string> findItinerary(vector< pair<string, string> > tickets)
	{
		for (int i=0; i<(int)tickets.size(); ++i)
			graph[tickets[i].first].insert(tickets[i].second);
		dfs("JFK");
		reverse(ans.begin(), ans.end());
		return ans;
	}
};

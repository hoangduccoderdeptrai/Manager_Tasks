#include <iostream>
#include<vector>
#include<map>
#include<algorithm>
using namespace std;
class Solution {
public:
    vector<int> findSubstring(string s, vector<string>& words) {
        map<string,int>mp,mark;
        int size_word =words[0].size();
        int size_vector =words.size();
        int length =words.size()*size_word;
        vector<int>ans;

        for(auto x:words)mp[x]++;
       
        int size_mp =mp.size();
        for(int i=0;i<s.size()-length+1;i++){
            mark.clear();
            int dem=0;

            for(int j=0;j<size_vector;j++){
                int left =i;
                string t =s.substr(i+j*size_word,size_word);
                mark[t]++;
                if(mp.find(t)!=mp.end() && mp[t]==mark[t]){
                    dem++;
                }
                
                
                
            }
            if(dem==size_mp){
                ans.push_back(i);
            }

        }
        return ans;
    }
};
int main(){
    string s ="wordgoodgoodgoodbestword";
    vector<string>world{"word","good","best","good"};
    vector<int>vt;
    Solution t;
    vt =t.findSubstring(s,world);
    for(auto x:vt)cout<<x<<" ";
}
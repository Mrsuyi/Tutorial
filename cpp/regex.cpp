#include <iostream>
#include <regex>

using namespace std;

void simple()
{
    string pattern = "[A-Z]+\\d+";
    regex r(pattern);
    smatch results;
    string s = "abcA1def";

    if (regex_search(s, results, r))
    {
        cout << results.str() << endl;
    } 
}

void multiple()
{
    string pattern = "[A-Z]+\\d+";
    regex r(pattern);
    string s = "abcA1defB2hijC3";
    
    for (sregex_iterator it(s.begin(), s.end(), r), end_it; it != end_it; ++it)
    {
        cout << it->str() << endl;
    }
}

void sub()
{
    string pattern = "\\[([A-Z]+\\d+)\\]";
    regex r(pattern);
    string s = "abc[A1]def[B2]hij[C3]";

    for (sregex_iterator it(s.begin(), s.end(), r), end_it; it != end_it; ++it)
    {
        cout << it->str(1) << endl;
        const smatch& results = *it;
        cout << results[1] << endl;
    }
}

void substitute()
{
    string pattern = "\\[([A-Z]+\\d+)\\]";
    regex r(pattern);
    string s = "abc[A1]def[B2]hij[C3]";

    cout << s << endl;

    for (sregex_iterator it(s.begin(), s.end(), r), end_it; it != end_it; ++it)
    {
        cout << it->str() << endl; 
        s.replace(s.begin() + it->position(), s.begin() + it->position() + it->length(), "shit");
    }

    cout << s << endl;
}

int main()
{
    substitute();

    return 0;
}

# Find-citations-from-the-paper-0.1-
When publish a paper, the citation apeared in the text need to apear in the reference list. However, such check is very time consuming, especially you have a relatively long paper.
This project will include codes that can output the potential citations from the paper.
当发表文章的时候，通常文献列表中的文献要和正文中出现的文献保持一致，但是一个一个去检查耗费时间，而且容易出错。这个代码能输出正文中可能的文献。

**How to use it如何使用 :**
1. copy all the content of the paper (only for windows, because the input function in R is only used in windows)复制全文（只能同于windows系统，因为代码只能读取windows的剪切板）
2. set the saving pathway at the end of the code 设置代码最后一行的 保存路径
3. run the code 运行所有代码

**steps of the filtration 引用 筛选的步骤:**
1. find parenthesis 找到括号
2. record content in the parenthesis 记录括号中的内容
3. remove the content without Year (year range 1000-2024, 2024 is the year I will graduate)去掉不包含年份的内容（年份范围1000-2024年，2024年是我毕业的年份，哈哈）. Normally, the citation in the text is like this: (author year); (author et al., year), including Year. 因为通常，文中的引用如：（作者, 年份）；（作者 等., 年份）等包含了年份
4. remove the content just include one words去掉只有一个词的内容. Normally, the citation in the text is more than one words 通常，文中的引用，多于一个词
5. remove the redundant content.去掉重复的内容

Hope can be helpful!希望能有用！

**Possible error reporting 可能的报错**
1. when you have '(', but do not have ')', or have ')', but do not have '('.
2. Can not find citations like 'Year' + 'a', such as (Tan et al. 2021a). 

---
title: Guide for creating website using Hexo and Github
date: 2017-06-03 10:51:01
tags: 
- Developer
---

This website was created with one idea in mind - Minimalism. My previous websites were designed using Jekyll and Hugo. I needed to switch to a new framework for two reasons: continue the learning and build things that can scale. I came across [Hexo](https://hexo.io/). Hexo is a blog framework that is built on Nodejs. The features of Hexo are: 
* It's easy to generate new pages 
* You only need a single command to deploy your website 
* Lots of [Plugins](https://hexo.io/plugins/) 
* It can easily be used for production. I found Hexo to be better than Jekyll and faster than WordPress and Drupal 

Hexo is a bit slower than Hugo (We can't beat the speed of Go at HTTP serving), but for my requirements, this is fast enough. 

The source code for this website can be found [here](https://github.com/ajnarayan/ajnarayan.github.io). Feel free to raise an issue or suggest an improvement. 

**NOTE:** This guide is mainly focussed on Mac environment. 

### Requirements 
There are only 2 prerequisites to run hexo:
-  Node.js is installed
-  Git is installed

### Steps

**Step 1:** Create a new Github repo in form `username.github.io`. 

**Step 2:** Install hexo 
```
$ npm install -g hexo-cli
```
if you encounter any problem during this installation, it is mainly because Xcode is not installed. You can go to app store and install Xcode. 

**Step 3:** Once Hexo is installed, create a <folder> where you want all your code to be present and follow these steps: 
```
$ hexo init <folder>
$ cd <folder>
$ npm install
```
Your folder should now look like this: 
```
.
├── _config.yml
├── package.json
├── scaffolds
├── source
|   ├── _drafts
|   └── _posts
└── themes
```

**Step4:** Choose a [theme](https://hexo.io/themes/) or you can start from scratch and create one by modifying the [configs](https://hexo.io/docs/configuration.html) 

**Step5:** Modify the configs as per your requirement. You can refer [this](https://hexo.io/docs/configuration.html) for more details on each field.

**Step6:** Once you have the theme in your themes folder (Make sure you have added the theme in your _config.yml), You are all set to see your website come alive
```
$ hexo generate
$ hexo serve
```
Your website will come up on your localhost.

**Step7:** push the code to the repo in git.

### To create a new post

```
$ hexo new "My New Post"
```
You should find the .md file in source/_posts
Write the contents and test it:

```
$ hexo generate
$ hexo serve
```

### Deploy
After you are satisfied with your website, it's time to deploy it. 

Install Hexo-git-deploy plugin:
```
$ npm install hexo-deployer-git --save
```

Before you deploy, you need to make sure that you have the deploy configs in your _config.yml
```
deploy:
  type: git
  repo: https://github.com/<username>/<username>.github.io.git
  branch: master
```

Once this is done, you are ready to deploy!!!!! 

```
$ hexo deploy
```

**Happy Blogging!** 

#### Useful Links
- [Github Markdown Cheat Sheet](https://guides.github.com/pdfs/markdown-cheatsheet-online.pdf)
- [Another Markdown Cheat Sheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet#code)
- [Hexo](https://hexo.io/)
- [Theme I have Used](https://github.com/probberechts/cactus-dark)

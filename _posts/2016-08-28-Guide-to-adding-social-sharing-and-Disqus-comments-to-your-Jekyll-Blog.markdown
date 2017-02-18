---
layout: post
title: Guide to adding social sharing and Disqus comments to your Jekyll Blog  
date: 2016-08-28 10:30:31
image: /assets/images/markdown.jpg
headerImage: false
tag:
- markdown
- components
- extra
blog: true
author: anjjannarayan
description: Guide to adding social and Disqus comments to your Jekyll Blog
---

In my previous blog post I had writen a guide that enables you to create your own blog using Jekyll. In this blog post we will describe the necessary steps to append links to share your blog on Twitter, Facebook and Google+. 

**Step 1** In the **_includes/** directory, you should find a html file named **share.html**. If you don't find one, you can simply create a new file

**Step 2** Paste the following code in **share.html**

```html
<div class="share-page">
	Share this on &rarr;
    
    <a href="https://twitter.com/intent/tweet?text={{ page.title }}&url={{ site.url }}{{ page.url }}&via={{ site.twitter_username }}&related={{ site.twitter_username }}" rel="nofollow" target="_blank" title="Share on Twitter">Twitter</a>
	
	<a href="https://facebook.com/sharer.php?u={{ site.url }}{{ page.url }}" rel="nofollow" target="_blank" title="Share on Facebook">Facebook</a>
    
    <a href="https://plus.google.com/share?url={{ site.url }}{{ page.url }}" rel="nofollow" target="_blank" title="Share on Google+">Google+</a>
</div>
```

**Step 3** Include this **share.html** page to Post layout. ie. In **_layouts/** directory, you will find post.html. Include the following in the file: 

```html
{%raw%}
{% include share.html %}
{%endraw%}
```


Now you should have a working share button for your blog posts (Just like the ones you see below !). 

##Enabling Disqus comments on your blog 

**Step 1** Register your domain (username.github.io in this case) with [Disqus](https://disqus.com/features/)

**Step 2** Get a customized embedded code [here](https://disqus.com/admin/universalcode/). You can also edit the code to add your unique identifier for your domain

**Step 3** Once you get the code, paste it in **_includes/** directory and name it as **disqus.html**

**Step 4** In the directory **_layouts/** , edit the **post.html** and add the following: 

```html
{%raw%}
{% include disqus.html %}
{%endraw%}
```

These basics should do the trick. If you are facing any troubles, feel free to comment below. 
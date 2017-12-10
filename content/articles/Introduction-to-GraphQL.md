---
author: Anjjan Narayan
date: 2017-12-10
title: Introduction to GraphQL
linktitle: Introduction to GraphQL
tags: 
- Developer
---

### What is GraphQL

As a developer, you will be used to having new technologies and frameworks being released every couple of months. There are three stages after encountering a new technology;
 * Stage 1 - Rejection - why should I use it when I already have <Insert an awesome technology you are currently using> 
 * Stage 2 - Attraction - Maybe I should check what the buzz is about?
 * Stage 3 - Dedication - Let's go ahead and learn this and see how I can use it in my current scenario 

Currently, I fee I am in stage 2 of this 3 stage process. Having heard a lot about GraphQL from its time of inception, now is the perfect time to learn what GraphQL is and what's all the buzz about? 


On a high level, [GraphQL](http://graphql.org/) basically is an interface that lets you decide what data you want. Based on this, it loads the data from the server and presents it to the client. 

If you are the kind of person who relies on old school definitions then here it goes; 

>> GraphQL is a query language for your API, and a server-side runtime for executing queries by using a type system you define for your data.

The gist of GraphQL is that it lets you (the client) specify the exact data that you need. To achieve this, GraphQL uses a type system to describe the data. 

### How did GraphQL come into existance?

Facebook started GraphQL after they faced several limitations in REST APIs. 

Consider the following example; 
Let's take the example of an Instagram post. Say you have to display the instagram picture, number of likes and preview of comments along with the user who commented and the content of the comment. Ideally what you would do in a REST API world is that you would have an API that would return to you something like this: 
```
{
	{
		post: catimage.jpeg
		likescount : 100 
		commentsection : [ {
				name: 'LionelMessi'
				content: 'Nice picture'
			},
			{
				name: 'CR7'
				content: 'Dude, you stole my cat!'
			} 
		]
	},
	{
		post: dogimage.jpeg
		likescount : 100 
		commentsection : [ {
				name: 'LionelMessi'
				content: 'Not bad'
			}
		]

	}
}

```

Say you want to optimize this by having only the posts and likescount and not commentsection. I want the commentsection to be a link which on clicked should show the comments. The above JSON result above would be large in size as the number of comments keeps increasing. In this case you would need to add another endpoint which would only give you post and likescount. Now you have two endpoints, one giving only post and likescount and the other giving posts, likescounts and commentsection. 

You can see where we are heading to. As more and more requirements come, we would end up having multiple APIs which basically query the same backend but only display result in differnt manner. 

If we don't want to have multiple APIs, we can give the client the entire (above) JSON. The client would have to manipulate the JSON inorder to extract only the necessary details. There are many obvious drawback to this (Network latency with huge JSON payload, Redundant Client transformation Code, etc.). 

There can also be a situation that the commentsection details is coming from a Cassandra database whereas the likescount (which can increase from time to time) is coming from Redis or Memcache store. 

As the number of datastores increases and the number of APIs increases, it becomes hard to manage this. This one example of a limitation that REST APIs posses. 

## The Solution to this Problem:  

Facebook came up with GraphQL to solve these drawbacks. Why not have a single "smart" endpoint that can handle multiple queries and transform the result so as to match only what the client requested?

<div class="image ">
        <img class="image" src="/images/article_metadata/GraphQL_Request.png" align="center" alt="Alt Text">
        <figcaption class="caption" align="center">GraphQL Request (Source graphql.org)</figcaption>
 </div>

<div class="image ">
        <img class="image" src="/images/article_metadata/GraphQL_Response.png" align="center" alt="Alt Text">
        <figcaption class="caption" align="center">GraphQL Response (Source graphql.org)</figcaption>
 </div>

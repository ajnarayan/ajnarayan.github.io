---
author: Anjjan Narayan
date: 2017-12-10
title: Introduction to GraphQL
linktitle: Introduction to GraphQL
tags: 
- Developer
---

### What is GraphQL

As a developer, you will be used to having new technologies and frameworks being released every couple of months. There are three stages after encountering a new technology:

 * Stage 1 - Rejection - why should I use it when I already have <Insert an awesome technology you are currently using> 
 * Stage 2 - Attraction - Maybe I should check what the buzz is about?
 * Stage 3 - Dedication - Let's go ahead and learn this and see how I can use it in my current scenario 

Currently, I feel I am in stage 2 of this 3 stage process. Having heard a lot about GraphQL from its time of inception, now is the perfect time to learn what GraphQL is and what's all the buzz about? 


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

Facebook came up with GraphQL to solve these drawbacks. 

Why not have a single "smart" endpoint that can handle multiple queries and transform the result so as to match only what the client requested?

<div class="image ">
        <img class="image" src="/images/article_metadata/GraphQL_Request.png" align="center" alt="Alt Text">
        <figcaption class="caption" align="center">GraphQL Request (Source graphql.org)</figcaption>
 </div>


<div class="image ">
        <img class="image" src="/images/article_metadata/GraphQL_Response.png" align="center" alt="Alt Text">
        <figcaption class="caption" align="center">GraphQL Response (Source graphql.org)</figcaption>
 </div>

### REST vs GraphQL

Assume that we need to build an API that should return to us details about a football club. As per requirements, the UI needs to have a view where given a football club (Eg. Chelsea FC), I must get information of the club such as ClubName, YearofEstablishment, titles, and CurrentSeasonUpdate. 

This may sound straightforward, but we need to get data from multiple resources. These resources are club details, title details and season details.  

The JSON we need would look like this:
```
{
	"data": {
		"ClubName": "Chelsea FC",
		"Manager": "Antonio Conte",
		"YearOfEstablishment": "1905",
		"CurrentSeasonUpdate": {
			"position": 3,
			"LastGameAgainst": "Huddersfield",
			"Home/Away": "A",
			"Result": "1-3"
		},
		"Titles": [{
				"name": "Premier League",
				"year": 2016
			},
			{
				"name": "Champions League",
				"year": 2012
			},
			{
				"name": "Europa League",
				"year": 2013
			}
		]
	}
}

```

If I needed this from a REST request, my requests would be something like this; 

```
GET myservice:8080/GetClubDetails/{ClubName}
```

This would have given us details like this: 

```
{
		"ClubName": "Chelsea FC",
		"Manager": "Antonio Conte",
		"YearOfEstablishment": "1905",
		"CurrentSeasonId": 1056701,
		"ClubId" : "11111"
		"TitleID" : [1, 3, 6, 8] 
		...
}

```

In order to get the CurrentSeason stats (which may reside in another datasource like kafka), I would need to perform another GET call;

```
GET - myservice2:8080/SeasonStats/{seasonid}/{clubId}

```

and similarly, 

```
GET - myservice3:8080/TitleDetails/1/{clubID}               ---> 1 for details on only premier league victories
GET - myservice3:8080/TitleDetails/3/{clubID}               ---> 3 -or details on only Champions league victories
```

We can see the drawbacks slowly creeping in. In order to get the required JSON in my UI, I would need to have my API call 3 different services, combine these data and map it to my respective output. 

As we try to scale our service, we will eventually keep adding new endpoints and new code in the top layer to handle these multiple endpoint results. 

What GraphQL solves for us here is that it takes this custom endpoint idea and combines them. In other words, the GraphQL server will just be a single server with one endpoint. 

Here is how it would work. We would declaratively specify to the server what details we need in the form of a query. It is basically saying the graphQL server that *hey, I need to know my clubs name, manager, yearofEstablishment, SeasonStats and the titles*. 

```
GET - /graphql?query={
	clubName(id: 1111){
		Manager,
		YearOfEstablishment,
		CurrentSeasonUpdate{
			position,
			LastGameAgainst,
			Home/Away,
			Result
		},
		Titles {
			name, 
			year
		}
	}
}
```

GraphQL query is very similar to JSON without values. Take the response from JSON, remove the values and you have a graphQL query. 

From the Frontend UI persepective, all they need to do is query the graphQL server with what they need and it is exactly what they will get. No hastle, no multiple requests, no transformations etc. 

### The Conclusion

A new technology is only useful when it solves a problem. There are many underlying GraphQL concepts that have not been mentioned here. These concepts will make you realize if GraphQL really solves your problem. I hope that this article will serve as a brief introduction to folks who want to know what all the fuss is about.


P.S: As an ongoing experiment process to transforming into step 3 (Dedication) of understanding a new technology, I am currently working on a practical implementation of GraphQL. Refer [this](https://github.com/ajnarayan/codehood) for more information. 
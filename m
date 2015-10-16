Return-Path: <ki4jgt@gmail.com>
From: Jesse <ki4jgt@gmail.com>
Message-ID: <56215B00.1070808@gmail.com>
Date: Fri, 16 Oct 2015 15:16:00 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Starting a cellular network
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hey guys,

I tried the IRC and didn't get a response. I have limited time on the 
Internet each day so I thought I'd try here. I would like to develop a 
cellular network which runs off of ad hoced 802.11 technology. I'm kind 
of tired having to pay a $40 cellphone bill to keep in contact with two 
other people (at most). I see no justification in this since there are 
already so many more viable options available.

I would like to develop an open standard which is free for everyone to 
implement and utilize for their own needs. Before I get people 
commenting on how it's already been done, I'd like to say, not like this.

The system I'm proposing is built on top of 802.11 ad hoc. Messages are 
chopped into 4096 byte segments before delivery (I'm considering upping 
that to 10 kB). It's capable of delivering text messages, walkie-talkie, 
and files.

I have used avahi-autoipd to implement an IPv4 connection over this 
network and have given all devices in the network, the same BSSID, SSID, 
and channel.

This network uses two ports 4100 and 4200. 4100 is for broadcasts. 4200 
is for TCP connections with surrounding peers. Each json message is 
stamped with a 30 character id. The first 15 characters are an sha512 
hash of the message recipient's public key. The second are an sha512 
hash of the message itself.

Each node keeps up with the last 1000 segments it's been given (in RAM). 
Anything older than that is deleted.

Every 30 seconds (timer starts when peer joins network) nodes send out a 
get broadcast for their messages via UDP (GET SHA-KEY-HASH UNIQUE ID). 
Each peer in the network rebroadcasts this message. Hashes of the last 
1000 messages are kept in each server as well. If a message hash is 
already in server, it isn't rebroadcast (no loops). After the broadcast 
for messages, the network sends a json list back to them containing all 
the messages the network has which are addressed to that user.

It is the user's discretion which messages to request from the group 
from there. Basically, they pick out the ones they don't already have. 
Another get request is sent GET HASHED-KEY-MESSAGE-HASH (the unique ID 
for the entire message). The particular message is sent back to the user 
(via TCP), using paths constructed from the GET requests.

I would like to extend this to an online P2P network so recipients could 
be part of a global community. Imagine texting your friends in country-x 
for free because someone was kind enough to plug their tower into their 
wifi network. By default, this will not share an Internet connection, 
just texting, walkie-talkie, and file-sharing. I've heard so many people 
complaining about the B.A.T.M.A.N. network sharing their Internet 
connection and them routing it through a VPS to avoid any legal problems.

I have a problem with my service though. If/When the numbers reach 
10,000 users, I don't really see everyone in the network requesting 
their messages from everyone else in the network.

The possibilities of this network would be endless. No more texting fees 
from major carriers for one. No Internet security risks from sharing the 
network. If the power and Internet went out in areas, people would still 
be able to chat via battery back-up towers they build themselves. Since 
there will be online gateways, there's the possibility that any device 
with wifi access can communicate with these open standard gateways and 
deliver messages to anyone on the network (direct Internet access or 
not). Friends could download your messages when you're offline. Then you 
just request them from others on your friend's list.

Any help with this would be extremely appreciated. I want this to work 
out of the box. I have my own money making schemes for this service 
worked up already and would like to make an entire industry from it. 
Thank you all and sorry for the wall of text. Have a nice day guys.

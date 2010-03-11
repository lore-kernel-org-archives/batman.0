Return-Path: <michaelfazio@me.com>
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Message-id: <8D692389-52C5-4CCB-BE58-D4B2E4D07161@me.com>
From: Michael Fazio <michaelfazio@me.com>
Date: Thu, 11 Mar 2010 22:12:34 +0800
Subject: [B.A.T.M.A.N.] B.A.T.M.A.N Suitability for MAGIC 2010
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hello,

		My name is Michael. I am currently working on a large robotics  
project and I am thinking of using B.A.T.M.A.N to facilitate a MANET  
to communicate between a number of bots and a base station. I was  
hoping to get a bit of information regarding the suitability of  
B.A.T.M.A.N for such an application. Any information would be helpful  
(general or specific). Here are some of the details of our project.

We will be using up-to 14 bots in our project (each must be network  
aware).
The area that our bots will be operating in is approximately the size  
of a football field.
There are both indoor and outdoor areas that must be navigated with a  
significant amount of obstacles.
We will be using 802.11a,b,g and possibly n as well as one or more  
long range VHF links which I am hoping to setup as additional entry  
points to our bot network.
We have various types of data to be communicated on our network  
including, GPS, basic telemetry, control message, imagery, UAV feeds,  
point cloud info etc.
Some data such as GPS and telemetry is realtime and need not be  
reliable (we are considering simply UDP broadcasting this data). Other  
data such as imagery and control messages will require stable links  
and need to be relatively reliable.
We are not yet sure if we will be deploying any specific middleware  
technology although I am partial to pub/sub middleware. Are there any  
such middleware that can complement B.A.T.M.A.N?

I was hoping to know what type of issues I might run into using  
B.A.T.M.A.N adv in such a scenario. For instance, what kind of  
throughput might I expect in the described environment? Link stability  
issues? General suitability? How would B.A.T.M.A.N compare to OLSR or  
Babel? I am really interested in anything that anyone has to offer.

The reason I am pushing for B.A.T.M.A.N is because of the ability for  
us to develop our application layer using IPv4 TCP/UDP on-top of a  
mesh network driven by routers running openWRT & B.A.T.M.A.N. I want  
to take as much network layer knowledge away from out application layer.

Also, does anyone know of other similar usages of B.A.T.M.A.N?

I have a bunch of studies from various organizations comparing  
B.A.T.M.A.N to other solutions but I would really appreciate to hear  
what the mail list users have to say about their own experiences with  
B.A.T.M.A.N.

I hope this is the right place to be asking all these questions!

Thanks Batmen & Batwomen!

Michael

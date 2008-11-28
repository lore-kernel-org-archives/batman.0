Message-ID: <49303E38.1050001@web.de>
Date: Fri, 28 Nov 2008 20:53:44 +0200
From: "Chris W." <chris-wy@web.de>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] 0.3.1 rv1152 - some test results
References: <492DDC20.7090900@web.de>
	<200811280043.26990.lindner_marek@yahoo.de>
	<49302F8E.2040502@web.de>
In-Reply-To: <49302F8E.2040502@web.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: chris-wy@web.de
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hello Marek,

with rv 1162 routing seems to be much better,
all nodes and subnets are reachable.

After some minutes I saw this error on 10.4.2.50:
Jan  1 05:55:40 wgt634u_50 daemon.err batmand[7357]: Error - can't add 
throw route to 10.2.50.0/24 via 0.0.0.0 (table 68): File exists

greetings,
Chris


>>> -3- previously announced networks are not deleted (8.106), the routing
>>> table collects multiple entries for the same destination
>>
>> Thanks for the hint. Fixed in revision 1159.
>>
> Yes, no multiple entries anymore in 1161.
> 
> The announced network of 2.72 gets lost after some minutes on all nodes.



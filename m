Return-Path: <feanpg@gmail.com>
Message-ID: <52655830.8080607@gmail.com>
Date: Mon, 21 Oct 2013 18:37:04 +0200
From: Fernando Pizarro <feanpg@gmail.com>
MIME-Version: 1.0
References: <52651870.3000001@gmail.com> <20131021122119.GC310@neomailbox.net>
 <800EA6FA-FE6F-4B95-B1C5-0DFAA4CDBF19@gmail.com>
 <20131021131745.GB1544@neomailbox.net>
In-Reply-To: <20131021131745.GB1544@neomailbox.net>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] Originators with cero TQ
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

El 21/10/13 15:17, Antonio Quartulli escribió:
> On Mon, Oct 21, 2013 at 01:23:37PM +0100, Bruno Alexandre Taraio dos Santos Antunes wrote:
>> I think its spanish for zero
> In that case..If I remember correctly you can have TQ=0 only for "Potential
> Netxthops". If an originator has a TQ=0 on the best path then it is should not
> be shown in the originator table.
>
> However, if you have further doubts, please post the table.
>
> Regards,
>
Hi all,

That's correct. Nodes with cero value (TQ=0) there are in "Potential 
Nexthops" but there are a lot of them in the originator table. In some 
cases, only there is one node with TQ major than 0. Example:

172.16.0.9    0.300s   (196)       172.16.0.36 [     wlan1]: 172.16.0.40 
(  0)       172.16.0.35 (  0)       172.16.0.22 ( 0)       172.16.0.39 
(  0)       172.16.0.33 (  0)       172.16.0.32 (  0)       172.16.0.36 
(196)

Full table in this link: hxxp://pastebin.com/6rpieA7y

There are another cases, a behaviour that I don't understand is this: 
Traffic is being routed using a SINGLE jump (or direct link) very low 
bandwidth to its target, but there are many other options with better 
bandwidth, however using more jumps/links, why is this happening and how 
can I control it?

Number of hop are more important than link quality to calculate TQ 
value? Is there any "well-known formula" to calculate TQ?

I make some tests changing default class of a client to 3 (batctl gw 
client 3) with same results. What is the best client value for a large 
enviroment (about 40 AP's)?

Thanks for all.
Regards, Fernando.

Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 6 Jul 2010 23:42:49 +0200
References: <C996A616-0036-4092-B2E3-23A34FB14B95@7degrees.co.za>
In-Reply-To: <C996A616-0036-4092-B2E3-23A34FB14B95@7degrees.co.za>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201007062342.50060.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] The great #batdroid hackathon of July 2010
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
Cc: Steve Song <steve.song@shuttleworthfoundation.org>, Neels van der Westhuizen <neels@rossum.co.za>, Edwin Blake <edwin@cs.uct.ac.za>, village-telco-dev@googlegroups.com


Hey all,

> Over the weekend a team consisting of Tatenda Chipeperekwa, Veenesh Jeena,
> Zaheer Abrahams from the UCT Honors program as well as YoursTruly
> succeeded in writing an App which allows anyone with a rooted Android
> handset to connect to a B.A.T.M.A.N. mesh network.
> 
> Work began on Saturday morning by bringing up a simple mesh testbed
> consisting of a Mesh Potato, an Ubiquity NS2 and a Linksys WRT54GL. The
> rest of the day was spent manually configuring the test phones into AdHoc
> mode and bringing the batmand mesh routing daemon up on both a HTC Magic &
> a HTC Legend.

congratulations to all involved for the success of this project! It makes me 
happy seeing people coming together to work on a project, especially when it 
is about batman.  ;)

I experimented with mesh on the phones / mobile devices myself not so long ago 
and noticed that the energy consumption is pretty high. Even if we had no mesh 
the ad-hoc mode does not allow to save as much energy as the managed mode. Did 
you notice the same thing ? How long does the battery last ?

In an environment which provides a "backbone" network (e.g. routers) batman-
adv might be more suitable, since the clients do not need any mesh software 
nor ad-hoc mode and still can roam around. Did you give it a try ?

Regards,
Marek

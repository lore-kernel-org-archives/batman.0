Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 29 Oct 2009 21:04:13 +0800
References: <45f642440910260327u6eb01bc3nf468cc092fa8700@mail.gmail.com>
In-Reply-To: <45f642440910260327u6eb01bc3nf468cc092fa8700@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200910292104.13536.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv metric and next-hop choice
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


Hi,

> I am experimenting some path hopping in my tests using batman-adv.
> Was wondering if and where metric information are shared among batman nodes
> (again, with batman-adv) as I did not find any useful infos sniffing
>  packets with wireshark patched.
> 
> The command batctl l shows (with log level 8)
> But no info about actual metric when a route is changed.

I'm not entirely sure what you expect to find or what is missing. If you want 
to understand the batman protocol you might want to start with some of our 
recorded talks. If you want to use wireshark to analyze the traffic be sure to 
have the batman dissectors installed (or use batctl td). If you want routing 
debug information from the module use debug level 12 (batman [4] + routes 
[8]).

Hope that helps,
Marek

Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 25 Nov 2009 21:11:08 +0800
References: <45f642440910260327u6eb01bc3nf468cc092fa8700@mail.gmail.com>
	<200910292104.13536.lindner_marek@yahoo.de>
	<45f642440911250226s1ea87735ja8639d433ba7c942@mail.gmail.com>
In-Reply-To: <45f642440911250226s1ea87735ja8639d433ba7c942@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200911252111.08637.lindner_marek@yahoo.de>
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

> I was just looking for a name: the name of the metric (is that ETX?) that
>  is used in batman-adv.
> Actually i did not find any useful info in old messages on the list.

The metric used by batman-adv is called TQ (Transmission Quality) and 
expresses the sending link quality from the current node all the way down to 
the destination.

There is a document explaining the main ideas behind the algorithm used by 
batman-adv that you can download here:
http://gitorious.org/batman-adv-doc

Disclaimer: This paper is not an official document / complete / meant to be a 
RFC / etc. Use it at your own risk.  ;)

Regards,
Marek

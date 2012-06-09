Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 9 Jun 2012 22:58:00 +0800
References: <CAA_JP8XWzyv5-eYhCxCrMEt-y6RTYu=qe6e=vYTXT1oi-H5O=g@mail.gmail.com>
In-Reply-To: <CAA_JP8XWzyv5-eYhCxCrMEt-y6RTYu=qe6e=vYTXT1oi-H5O=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201206092258.00955.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] any progress or info on available throughput
	based routing?
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Friday, June 08, 2012 07:45:31 dan wrote:
> I have been watching batman-adv for quite a while.  I really love the
> progress that the devs have made and the concepts are great.
> 
> I think the holy grail of mesh routing protocols is to handle 3
> characteristics of routes and route choice per packet type, possibly
> using DSCP/TOS values or something.
> 
> Those 3 characteristics are link quality, latency, and available
> throughput.  And the multiple routing tables would be so that services
> requiring low latency can be routed on lowest latency routes, that may
> not have a lot of throughput, and bulk traffic can be routed through
> paths that have more available throughput.
> 
> I have seen posts discussing interest in adding such features and I am
> interested to do some reading on this subject as it pertains to
> batman-adv.  Is there anything out there?  I couldn't find anything on
> the site.

AFAIK nobody plans to implement multiple routing tables as you are suggesting 
here. Unless I missed something ?

Regards,
Marek

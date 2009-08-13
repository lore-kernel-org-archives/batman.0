Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 14 Aug 2009 00:00:29 +0800
References: <20090722105639.GH32143@ma.tech.ascom.ch>
	<200908131756.57929.lindner_marek@yahoo.de>
	<OFB71ACC02.50DE5AF7-ONC1257611.0052A304-C1257611.00530C28@CHASCOM.INT>
In-Reply-To: <OFB71ACC02.50DE5AF7-ONC1257611.0052A304-C1257611.00530C28@CHASCOM.INT>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200908140000.30125.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman goes looping...
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

On Thursday 13 August 2009 23:07:06 Yang Su wrote:
> Maybe I miss some thing here. What do you think would prevent A from
> choosing via the long route (via B) ?

The starting point (still using your example):
* A points to E as it never learned about the long path.
* B points to C because it learned about the long path but does not 
rebroadcast the packets from C because they are slower than the 
packets via A.
* C uses the longer path.

Your idea: Use the echo cancellation's answer to retrieve more information, 
especially when the TQ which is coming back is worse than my own I update my 
routing information.

The situation now:
* A still points to E because the echos coming from B do not contain TQ values 
that are worse than its own.
* B will probably never route via A because the TQ values are much worse.
* C is not affected.

Did I overlook something ?

Regards,
Marek

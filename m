Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 12 Aug 2009 00:42:21 +0800
References: <20090722105639.GH32143@ma.tech.ascom.ch>
	<OF15A3814D.94B5B275-ONC125760E.002B50BE-C125760E.002BB709@CHASCOM.INT>
	<200908101616.50082.lindner_marek@yahoo.de>
In-Reply-To: <200908101616.50082.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200908120042.21853.lindner_marek@yahoo.de>
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

On Monday 10 August 2009 16:16:49 Marek Lindner wrote:
> Excellent question - it should. I will check the code later to verify that
> this is the case.
> However, this is not related to the echo cancellation anymore.

I inspected the code for behaviour in the case you outlined. I think our 
dropping policy might be a bit too strict. I suggest the following behaviour:

* New OGMs are processed and rebroadcasted as usual.
* Known OGMs (the sequence number is not new but we did not hear this sequence 
number via that neighbor) are processed and rebroadcasted as well.
* Duplicates (known sequence number via a neighbor that sent us this sequence 
number before are dropped.

Objections / ideas ?

Regards,
Marek


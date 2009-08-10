Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 10 Aug 2009 16:16:49 +0800
References: <20090722105639.GH32143@ma.tech.ascom.ch>
	<200908101548.53459.lindner_marek@yahoo.de>
	<OF15A3814D.94B5B275-ONC125760E.002B50BE-C125760E.002BB709@CHASCOM.INT>
In-Reply-To: <OF15A3814D.94B5B275-ONC125760E.002B50BE-C125760E.002BB709@CHASCOM.INT>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908101616.50082.lindner_marek@yahoo.de>
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

On Monday 10 August 2009 15:57:29 Yang Su wrote:
> -- B has already rebroadcasted an earlier OGM with the same sequence number
> (received from A). Will B rebroadcast the OGM with the same sequence number
> (received from C) again?

Excellent question - it should. I will check the code later to verify that 
this is the case. 
However, this is not related to the echo cancellation anymore.

Regards,
Marek


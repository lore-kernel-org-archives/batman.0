Return-Path: <post@tiwoc.de>
Message-ID: <4BF55F11.9070704@tiwoc.de>
Date: Thu, 20 May 2010 18:10:57 +0200
From: Daniel Seither <post@tiwoc.de>
MIME-Version: 1.0
References: <4BF55C08.7010704@tiwoc.de>
In-Reply-To: <4BF55C08.7010704@tiwoc.de>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Correct mdev calculation in ping
 subcommand
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

Sorry, I sent the wrong version of the patch. I'll send a fixed patch in
a minute...

- Daniel

Am 20.05.2010 17:58, schrieb Daniel Seither:
> Fixes the calculation of the mean absolute deviation (mdev)
> of the roundtrip times. mdev was previously calculated by
> computing the difference of maximum and minimum round trip times.
> 
> The calculation is now done using the same formula as in the iputils
> ping program.
> 
> Signed-off-by: Daniel Seither <post@tiwoc.de>
> ---

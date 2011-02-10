Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 10 Feb 2011 14:36:42 +0100
References: <201102091918.42080.lindner_marek@yahoo.de>
	<1297275550-12420-2-git-send-email-lindner_marek@yahoo.de>
	<20110210130303.GD13038@Sellars>
In-Reply-To: <20110210130303.GD13038@Sellars>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201102101436.43136.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: remove extra layer
	between hash and hash element - hash bucket
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

On Thursday 10 February 2011 14:03:03 Linus L=C3=BCssing wrote:
> Isn't there a #define with < KERNEL_VERSION(2, 6, 37) missing?
> (Haven't checked much else about this patch yet)

Why would there be a need for .37 (this functionality came with .34) ?
Nevertheless, you are right - it is missing here.

Regards,
Marek

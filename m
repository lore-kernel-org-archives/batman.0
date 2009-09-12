Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 13 Sep 2009 00:56:17 +0800
References: <1252750364-19308-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1252750364-19308-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200909130056.17963.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] [batman-adv] Remove compatibility code
	for pre 2.6 kernel versions
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

On Saturday 12 September 2009 18:12:44 Sven Eckelmann wrote:
> The earliest version of linux which is compatible to
> batman-adv-kernelland is 2.6.20. Their are patches available in debian
> for batman-adv-kernelland 0.1 to make it build against linux 2.6.15, but
> they cannot be ported to current trunk due to changes to the working
> queues. To have "support" for much older versions isn't needed and can
> be removed without loosing any functionality.

Thanks for the patch. Applied in r1436.

Regards,
Marek

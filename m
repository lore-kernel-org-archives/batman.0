Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 4 Jul 2011 20:37:51 +0200
References: <CAJA-1Lijvt9hZVTP0QXi81bk061A54tRs=quUyztzo2_cM-LNw@mail.gmail.com>
	<CAJA-1Ljmeqym_Sj4zqSEqaJtVvGf3brFQPtghYYi2QT5PFLYHw@mail.gmail.com>
	<20110704182256.GB26734@autistici.org>
In-Reply-To: <20110704182256.GB26734@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201107042037.52106.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Disconnecting the nodes in batman-adv 2011.1.0
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

On Monday, July 04, 2011 20:22:56 Antonio Quartulli wrote:
> As Marek suggested, you should use something like ebtables. But honestly I
> remember that ebtables support has been removed from batman some time
> ago.

You can still filter all packets from a certain mac address with ebtables. The 
batman-adv ebtables support was to filter specific batman-adv packets.

Cheers,
Marek

Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 28 Jun 2010 14:29:46 +0200
References: <1277307412-27661-1-git-send-email-sven.eckelmann@gmx.de>
	<1277323213-26460-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1277323213-26460-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201006281429.47418.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Move printk to simplified
	macros
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

On Wednesday 23 June 2010 22:00:13 Sven Eckelmann wrote:
> Each general printk which is not informative by itself for a specific
> batX device were moved to pr_(info|warning|err) as it provides an easy
> interface which for example resolves the problem to add the prefix
> "batman-adv: " before each line.
> 
> All information which is specific to a batX device will be printed using
> a bat_(info|err|warning) macro to prefix it also with "batman-adv:
> batX:" in each line.

Applied in revision 1729.

Thanks,
Marek

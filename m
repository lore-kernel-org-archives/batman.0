Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 12 Oct 2011 17:11:45 +0200
References: <1318249725-19865-1-git-send-email-ordex@autistici.org>
	<1318424090-22862-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1318424090-22862-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201110121711.46329.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: use orig_hash_find()
	instead of get_orig_node() in TT code
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

On Wednesday, October 12, 2011 14:54:50 Antonio Quartulli wrote:
> get_orig_node() tries to retrieves an orig_node object and possibly creates
> it if not present. This is not the wanted behaviours in the
> translation-table code, instead we want to get the orig_node only if it
> really exists, without creating it.

Applied in revision 62c7140.

Thanks,
Marek

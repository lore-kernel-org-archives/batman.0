Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 3 Jul 2013 18:11:17 +0800
References: <1372755876-3969-1-git-send-email-ordex@autistici.org>
 <1372755876-3969-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1372755876-3969-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201307031811.17498.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv11 1/3] batman-adv: add per VLAN
	interface attribute framework
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@open-mesh.com>, Antonio Quartulli <ordex@autistici.org>

On Tuesday, July 02, 2013 17:04:34 Antonio Quartulli wrote:
> Since batman-adv is now fully VLAN-aware, a proper framework
> able to handle per-vlan-interface attributes is needed.
> 
> Those attributes will affect the associated VLAN interface
> only, rather than the real soft_iface (which would result
> in every vlan interface having the same attribute
> configuration)
> 
> To make the code simpler and easier to extend, attributes
> associated to the standalone soft_iface are now treated
> like belonging to yet another vlan having a special vid.
> This vid is different from the others because it is made up
> by all zeros and the VLAN_HAS_TAG bit is not set.

Applied in revision 952cebb.

Thanks,
Marek

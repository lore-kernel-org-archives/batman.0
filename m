Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 9 Jun 2013 22:13:59 +0800
References: <1370340711-1399-1-git-send-email-ordex@autistici.org>
 <1370340711-1399-9-git-send-email-ordex@autistici.org>
In-Reply-To: <1370340711-1399-9-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201306092213.59813.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 08/13] batman-adv: treat bat0 like yet
	another VLAN
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Tuesday, June 04, 2013 18:11:46 Antonio Quartulli wrote:
> To make the code simpler and easier to extend, treat the
> normal LAN (bat0) like any other VLAN having vid 0
> (untagged).
> 
> This change makes things simpler since bat0 is not a
> particular case anymore but it is treated like any other
> VLAN.

What makes you think "vid 0" is not a valid vlan tag ? If this patch is 
applied how can I create a VLAN 0 on top of batX ?

Cheers,
Marek

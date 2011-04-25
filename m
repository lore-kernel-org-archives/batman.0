Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 26 Apr 2011 01:57:34 +0200
References: <1303723103-29582-1-git-send-email-ordex@autistici.org>
	<1303764272-5943-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1303764272-5943-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201104260157.35190.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4] batman-adv: fix gw_node_update() and
	gw_election()
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

On Monday 25 April 2011 22:44:32 Antonio Quartulli wrote:
> This is a regression from 8ffdea813e32cee3c60be36fb9e6a5e077e51ea0
> 
> - gw_node_update() doesn't add a new gw_node in case of empty curr_gw.
> This means that at the beginning no gw_node is added, leading to an
> empty gateway list.
> 
> - gw_election() is terminating in case of curr_gw == NULL. It has to
> terminate in case of curr_gw != NULL

Applied in revision 66b5d57.

Thanks,
Marek

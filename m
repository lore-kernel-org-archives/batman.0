Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 12 Jun 2011 12:09:58 +0200
References: <1307787342-24307-1-git-send-email-lindner_marek@yahoo.de>
	<1307787688-25242-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1307787688-25242-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201106121209.59081.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 2/3] batman-adv: throw uevent in
	userspace on gateway add/change/del event
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

On Saturday, June 11, 2011 12:21:28 PM Marek Lindner wrote:
> In case of new default gw, changing the default gw or deleting the default
> gw a uevent is triggered with type=gw, action=add/change/del and
> data={GW_ORIG_ADDRESS} (if any).
> 
> The gateway election mechanism has been a little revised. Now the
> gw_election is trigered by an atomic_t flag (gw_reselect) which is is set
> to 1 in case of election needed, avoding to set curr_gw to NULL.

Sven suggested splitting this patch, therefore I applied this in revision 
6a17ecc and c792264.

Thanks,
Marek

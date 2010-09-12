Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 12 Sep 2010 23:28:47 +0200
References: <201009122244.00861.sven.eckelmann@gmx.de>
	<1284325242-29661-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1284325242-29661-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201009122328.48460.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Unlock on failure during
	fragmentation rx
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

On Sunday 12 September 2010 23:00:42 Sven Eckelmann wrote:
> When we detect a failure in create_frag_buffer we must drop the packet
> and unlock the orig_has which was locked before.
> 69d187ffb8e22024a87d8457e5dcb10e297108e9 forgot that and created a
> potential deadlock of the complete system.
> 
> Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>

Good catch - applied in revision 1791.

Thanks,
Marek

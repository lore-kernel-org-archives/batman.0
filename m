Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 7 Jul 2011 14:37:27 +0200
References: <1309995659-19126-1-git-send-email-ordex@autistici.org>
	<1309995659-19126-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1309995659-19126-4-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201107071437.27656.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/3] batman-adv: keep global table
	consistency in case of roaming
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

On Thursday, July 07, 2011 01:40:59 Antonio Quartulli wrote:
> To keep consistency of other originator tables, new clients detected as
> roamed, are kept in the global table but are marked as TT_CLIENT_PENDING
> They are purged only when the new ttvn is received by the corresponding
> originator. Moreover they need to be considered as removed in case of
> global transtable lookup.

Applied in revision 4f7b492.

Thanks,
Marek

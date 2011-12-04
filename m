Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 4 Dec 2011 17:36:43 +0800
References: <1322945658-25154-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1322945658-25154-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201112041736.43389.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: in case of roaming mark the
	client with TT_CLIENT_ROAM
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

On Sunday, December 04, 2011 04:54:18 Antonio Quartulli wrote:
> Whenever we add a local client for which we already have a global entry,
> the latter has to be marked with the TT_CLIENT_ROAM flag (instead of
> TT_CLIENT_PENDING)

Am I right that this patch should go into linux 3.2 ? Maybe even to stable ? 
If so, which versions ? linux 3.0 and linux 3.1 ?
Are there more patches for stable from your end ? I'd like to send them in one 
go and not one by one ..

Regards,
Marek

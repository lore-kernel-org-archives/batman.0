Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 6 Dec 2011 01:04:10 +0800
References: <1322945658-25154-1-git-send-email-ordex@autistici.org>
	<1322998010-19221-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1322998010-19221-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201112060104.10384.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: in case of roaming mark
	the client with TT_CLIENT_ROAM
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

On Sunday, December 04, 2011 19:26:50 Antonio Quartulli wrote:
> In case of a client roaming from node A to node B, the latter have to mark
> the corresponding global entry with TT_CLIENT_ROAM (instead of
> TT_CLIENT_PENDING).
> 
> Marking a global entry with TT_CLIENT_PENDING will end up in keeping such
> entry forever (because this flag is only meant to be used with local
> entries and it is never checked on global ones).
> 
> In the worst case (all the clients roaming to the same node A) the local
> and the global table will contain exactly the same clients. Batman-adv
> will continue to work, but the memory usage is duplicated.

Applied in revision 913c412.

Thanks,
Marek

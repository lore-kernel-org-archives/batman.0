Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 9 Jul 2011 01:05:47 +0200
References: <1310161134-18515-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1310161134-18515-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201107090105.47816.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: keep local table consistency for
	further TT_RESPONSE
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

On Friday, July 08, 2011 23:38:54 Antonio Quartulli wrote:
> To keep transtable consistency among all the nodes, an originator must
> not send not yet announced clients within a full table TT_RESPONSE.
> Instead, deleted client have to be kept in the table in order to be sent
> within an immediate TT_RESPONSE. In this way all the nodes in the
> network will always provide the same response for the same request.
> 
> All the modification are committed at the next ttvn increment event.

Applied in revision 219bc39.

Thanks,
Marek

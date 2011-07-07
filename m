Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 7 Jul 2011 14:36:51 +0200
References: <1309995659-19126-1-git-send-email-ordex@autistici.org>
	<1309995659-19126-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1309995659-19126-3-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201107071436.51989.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/3] batman-adv: keep local table
	consistency for further TT_RESPONSE
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

On Thursday, July 07, 2011 01:40:58 Antonio Quartulli wrote:
> To keep transtable consistency among all the nodes, an originator must
> not send not yet announced clients within a full table TT_RESPONSE.
> Instead, deleted client have to be kept in the table in order to be sent
> within an immediate TT_RESPONSE. In this way all the nodes in the
> network will always provide the same response for the same request.
> 
> All the modification are committed at the next ttvn increment even

Applied in revision 6f4d271.

Thanks,
Marek

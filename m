Return-Path: <ordex@autistici.org>
Date: Thu, 16 Jun 2011 15:21:49 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110616132149.GB6077@ritirata.org>
References: <1308220627-27164-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1308220627-27164-1-git-send-email-lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix cleanup in
 send_tt_request()
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

On gio, giu 16, 2011 at 12:37:07 +0200, Marek Lindner wrote:
> The ret variable was never set to any value other than 0, therefore
> the skb and tt_req_node would not be freed in case of an error.
> Furthermore, the code assumed tt_req_node being always a valid
> pointer by dereferencing it in the cleanup part.
> 
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>

Acked-by: Antonio Quartulli <ordex@autistici.org>

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara

Return-Path: <ordex@autistici.org>
Date: Tue, 8 Nov 2011 18:50:42 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20111108175041.GA8405@ritirata.org>
References: <1320262005-15120-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1320262005-15120-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: check return value for
 hash_add()
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

On Wed, Nov 02, 2011 at 08:26:45 +0100, Simon Wunderlich wrote:
> if hash_add() fails, we should remove the structure to avoid memory
> leaks.
> 
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Acked-by Antonio Quartulli <ordex@autistici.org>


-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara

Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 9 Nov 2011 02:00:05 +0800
References: <1320262005-15120-1-git-send-email-siwu@hrz.tu-chemnitz.de>
	<20111108175041.GA8405@ritirata.org>
In-Reply-To: <20111108175041.GA8405@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201111090200.05627.lindner_marek@yahoo.de>
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

On Wednesday, November 09, 2011 01:50:42 Antonio Quartulli wrote:
> On Wed, Nov 02, 2011 at 08:26:45 +0100, Simon Wunderlich wrote:
> > if hash_add() fails, we should remove the structure to avoid memory
> > leaks.
> > 
> > Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> 
> Acked-by Antonio Quartulli <ordex@autistici.org>

Applied in revision c2e935f.

Thanks,
Marek

Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 16 Oct 2012 05:19:14 +0800
References: <1350332596-23684-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <1350333484-23781-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1350333484-23781-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210160519.15040.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/2] batman-adv: move hash_bytes into
	hash.h
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

On Tuesday, October 16, 2012 04:38:03 Simon Wunderlich wrote:
> This function will be used by other parts of batman-adv as well.
> 
> Reported-by: Marek Lindner <lindner_marek@yahoo.de>
> Reported-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> ---
>  bridge_loop_avoidance.c |   20 ++++----------------
>  hash.h                  |   18 ++++++++++++++++++
>  2 files changed, 22 insertions(+), 16 deletions(-)

Applied in revision f64999e.

Thanks,
Marek

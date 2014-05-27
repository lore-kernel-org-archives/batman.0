Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 27 May 2014 16:08:03 +0200
References: <1400931855-7961-1-git-send-email-sven@narfation.org>
In-Reply-To: <1400931855-7961-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201405271608.03313.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 01/10] batadv-vis: Avoid memory leak
	after failed realloc
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
Cc: Sven Eckelmann <sven@narfation.org>

> realloc doesn't free the original buffer when the reallocation failed. An
> abort of read_file without free'ing the buffer would leak it.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

The whole series has been applied with two minor fixes:
 * fixed a typo: alfred-gpsd: Fix altitute verification check -> altitude
 * fixed sign of length calculation in alfred: Fix length check for push_data

Thanks!
    Simon

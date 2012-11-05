Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 6 Nov 2012 02:55:04 +0800
References: <1351677149-6045-1-git-send-email-sven@narfation.org>
In-Reply-To: <1351677149-6045-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201211060255.05103.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Guarantee delimiter after
	snprintf
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

On Wednesday, October 31, 2012 17:52:29 Sven Eckelmann wrote:
> snprintf doesn't add a \0 delimiter when the size of the buffer is not big
> enough. The caller has to fix it manually to avoid crashes.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  bisect_iv.c |   10 ++++++----
>  debugfs.c   |    1 +
>  sys.c       |    8 ++++++++
>  3 files changed, 15 insertions(+), 4 deletions(-)

Applied in revision a5ead71.

Thanks,
Marek

Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 18 Oct 2012 02:58:11 +0800
References: <1350421286-30659-1-git-send-email-sven@narfation.org>
In-Reply-To: <1350421286-30659-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210180258.11466.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Add tool to translate
	mac/IPv4/bat_host to originator address
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

On Wednesday, October 17, 2012 05:01:26 Sven Eckelmann wrote:
> Users may want to get the originator which is responsible for a specific
> mac address. These addresses can be specified using IPv4 address, ethernet
> address or bat-host name.
> 
> For example, the output can be used to get the TQ value from the originator
> table when only the client address is known and not the gateway address.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  Makefile     |    2 +-
>  README       |   18 ++++++++++++++
>  main.c       |    6 +++++
>  man/batctl.8 |    5 ++++
>  translate.c  |   78
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> translate.h  |   24 ++++++++++++++++++
>  6 files changed, 132 insertions(+), 1 deletion(-)

Applied in revision c8e4fd4.

Thanks,
Marek

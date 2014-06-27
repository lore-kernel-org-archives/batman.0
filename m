Return-Path: <andrew@lunn.ch>
Date: Fri, 27 Jun 2014 03:58:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20140627015823.GA6079@lunn.ch>
References: <1403696158-20329-1-git-send-email-sven@narfation.org>
 <1403696158-20329-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1403696158-20329-2-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/2] alfred-gpsd: Avoid underrun when
	reading from gpsd
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Wed, Jun 25, 2014 at 01:35:58PM +0200, Sven Eckelmann wrote:
> The gpsd output reading function is ignoring \r characters. This is done by
> moving the current position (cnt) one position back in the character buffer. It
> is jumping to the -1 character (max number for size_t) when it was reading the
> first character at position 0. This is not problematic when the cnt is
> increased directly after it by 1. Overflows/underflows are defined for
> *unsigned* types and thus it just jumps back to 0.
> 
> Unfortunatelly, it is trying to access the memory for another check before
> increasing the position again. This check is done on memory outside of the
> buffer and therefore invalid.
> 
> Instead doing two check after each other, it is in this situation better to do
> both at once and just handle the current character.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Hi Sven

Thanks for the patch. I've now tested it. Works fine.

Tested-by: Andrew Lunn <andrew@lunn.ch>

   Andrew


> ---
>  gpsd/alfred-gpsd.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/gpsd/alfred-gpsd.c b/gpsd/alfred-gpsd.c
> index d6cdfd6..87943bd 100644
> --- a/gpsd/alfred-gpsd.c
> +++ b/gpsd/alfred-gpsd.c
> @@ -315,15 +315,16 @@ static void gpsd_read_gpsd(struct globals *globals)
>  			return;
>  		}
>  
> -		if (buf[cnt] == '\r')
> +		switch (buf[cnt]) {
> +		case '\r':
>  			cnt--;
> -
> -		if (buf[cnt] == '\n') {
> +			break;
> +		case '\n':
>  			eol = true;
>  			buf[cnt] = '\0';
>  			break;
>  		}
> -	} while (cnt++ < sizeof(buf) - 1);
> +	} while (cnt++ < sizeof(buf) - 1 && !eol);
>  
>  	if (!eol) {
>  		gps_close(&globals->gpsdata);
> -- 
> 2.0.0
> 

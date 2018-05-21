Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 21 May 2018 15:17:11 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20180521131711.GK7162@otheros>
References: <20180518014754.23644-1-mareklindner@neomailbox.ch>
 <20180518014754.23644-7-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180518014754.23644-7-mareklindner@neomailbox.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 6/7] batman-adv: ELP - use tp meter to
 estimate the throughput if otherwise not available
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Marek Lindner <mareklindner@neomailbox.ch>

On Fri, May 18, 2018 at 09:47:53AM +0800, Marek Lindner wrote:
> @@ -251,6 +253,21 @@ static void batadv_tp_caller_notify(struct batadv_priv *bat_priv,
>  
>  		break;
>  	case BATADV_TP_ELP:
> +		if (reason_is_error) {
> +			batadv_v_elp_tp_fail(tp_vars->hardif_neigh);
> +			return;
> +		}
> +
> +		test_time = jiffies_to_msecs(jiffies - tp_vars->start_time);
> +		total_bytes = atomic64_read(&tp_vars->tot_sent);
> +
> +		/* The following calculation includes these steps:
> +		 * - convert bytes to bits
> +		 * - divide bits by the test length (msecs)
> +		 * - convert result from bits/ms to 0.1Mb/s (* 1024 * 10 / 1000)
> +		 */
> +		throughput = total_bytes * 8 >> ilog2(test_time) / 10;
> +		batadv_v_elp_tp_finish(tp_vars->hardif_neigh, throughput);

I find the throughput calculation quite hard to read here, would
it be possible to put this into an extra (inline?) function?

Also the comment for the "convert result..." seems wrong,
"[bits/ms]*1024*10/1000" would be 0.01Mb/s, not 0.1Mb/s?

What is the advantage of using the ilog2 and shift operator here
compared to plain multiplications and divisions?

Also, when trying this in a small C program I get weird results:

-----
#include <stdio.h>
#include <math.h>

int main()
{
        unsigned long test_time = 10000;        // 10s
        unsigned long total_bytes = 20000000;   // 16MBit/s
        unsigned long throughput, throughput2;
        unsigned long log_test_time = log(test_time) / log(2);

        throughput = total_bytes * 8 >> log_test_time / 10;

	// Straightforward approach?
        throughput2 = total_bytes * 8 / test_time * 1000 / 1024 / 100;

        printf("Result: %lu (log_test_time: %lu)\n", throughput, log_test_time);
        printf("Result2: %lu\n", throughput2);

        return 0;
}
-----
$ ./test
Result: 80000000 (log_test_time: 13)
Result2: 156
$ file ./test
./test: ELF 32-bit LSB pie executable ARM, EABI5 version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-armhf.so.3, for GNU/Linux 3.2.0, BuildID[sha1]=d18f32829cdd2bc42cf744cdcafde7cdbd315cb0, not stripped
-----


Regards, Linus

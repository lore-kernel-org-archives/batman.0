Return-Path: <sven@open-mesh.com>
From: Sven Eckelmann <sven@open-mesh.com>
Date: Mon, 01 Feb 2016 13:26:12 +0100
Message-ID: <2398211.sq1Z83hZa4@bentobox>
In-Reply-To: <1454308474-23211-2-git-send-email-mareklindner@neomailbox.ch>
References: <1454308474-23211-1-git-send-email-mareklindner@neomailbox.ch>
 <1454308474-23211-2-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 next 2/3] batman-adv: convert wifi
	driver throughput to multiples of 100kbps
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
Cc: Thomas Huehn <thomas@net.t-labs.tu-berlin.de>, Marek Lindner <mareklindner@neomailbox.ch>, antonio@open-mesh.com

On Monday 01 February 2016 14:34:33 Marek Lindner wrote:
> The expected throughout returned by the cfg80211 API is expressed in kbps
> while internally batman-adv stores multiples of 100kbps. Ensure the
> conversion is performed properly.
> 
> Fixes: 5c324517 ("ELP - compute the metric based on the estimated throughput")
> 
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> ---
>  net/batman-adv/bat_v_elp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
> index 46c6a00..461a765 100644
> --- a/net/batman-adv/bat_v_elp.c
> +++ b/net/batman-adv/bat_v_elp.c
> @@ -100,7 +100,7 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
>  				return 0;
>  			}
>  			if (!ret)
> -				return sinfo.expected_throughput / 10;
> +				return sinfo.expected_throughput / 100;
>  		}

Just tested it here and can say that it now show the same value as
`iw dev adhoc0 station dump`. But the output of `iw dev adhoc0 station dump`
confuses me. I can get easily get over 40 Mbit/s but the output of
`iw dev adhoc0 station dump` show me 4.705Mbps. Also the output of
`cat /sys/kernel/debug/ieee80211/phy*/netdev\:adhoc0/stations/*/rc_stats` look
definitely more like ~40 Mbit/s.

Antonio, can you please check my tests and my conclusion (+patch [1]).

    root@OpenWrt:/# batctl tp ac:86:74:00:99:02
    Throughput meter called towards ac:86:74:00:99:02
    Test duration 10100ms.
    Sent 78082500 Bytes.
    Throughput: 7.37 MB/s (61.84 Mbps)
    root@OpenWrt:/# iw dev adhoc0 station dump; batctl o
    Station ac:86:74:00:99:02 (on adhoc0)
            inactive time:  130 ms
            rx bytes:       127568010
            rx packets:     322570
            tx bytes:       352672038
            tx packets:     310920
            tx retries:     3732
            tx failed:      0
            signal:         -22 [-30, -22] dBm
            signal avg:     -21 [-30, -22] dBm
            tx bitrate:     144.4 MBit/s MCS 15 short GI
            rx bitrate:     72.2 MBit/s MCS 7 short GI
            expected throughput:    4.705Mbps
            authorized:     yes
            authenticated:  yes
            preamble:       long
            WMM/WME:        yes
            MFP:            no
            TDLS peer:      no
    [B.A.T.M.A.N. adv 2016.0, MainIF/MAC: adhoc0/ac:86:74:08:39:92 (bat0 BATMAN_V)]
      Originator      last-seen ( throughput)           Nexthop [outgoingIF]:   Potential nexthops ...
    ac:86:74:00:99:02    0.290s (       8.1) ac:86:74:00:99:02 [    adhoc0]: ac:86:74:00:99:02 (       8.1)
    root@OpenWrt:/# cat /sys/kernel/debug/ieee80211/phy0/netdev\:adhoc0/stations/ac:86\:74\:00\:99\:02/rc_stats
    
                  best   ____________rate__________    ________statistics________    ________last_______    ______sum-of________
    mode guard #  rate  [name   idx airtime  max_tp]  [avg(tp) avg(prob) sd(prob)]  [prob.|retry|suc|att]  [#success | #attempts]
    CCK    LP  1          1.0M  120   10548     0.7       0.7     100.0      0.0     100.0   2     0 0             5   5        
    CCK    LP  1          2.0M  121    5476     1.5       1.5     100.0      0.0     100.0   0     0 0             1   1        
    CCK    LP  1          5.5M  122    2411     3.6       3.6     100.0      0.0     100.0   0     0 0             1   1        
    CCK    LP  1         11.0M  123    1535     5.7       5.7     100.0      0.0     100.0   0     0 0             1   1        
    HT20  LGI  1         MCS0     0    1477     5.6       5.6     100.0      0.0     100.0   1     0 0             1   1        
    HT20  LGI  1         MCS1     1     739    10.5      10.5     100.0      0.0     100.0   0     0 0             1   1        
    HT20  LGI  1         MCS2     2     493    14.9      14.9     100.0      0.0     100.0   0     0 0             1   1        
    HT20  LGI  1         MCS3     3     369    18.7      18.7     100.0      0.0     100.0   0     0 0             1   1        
    HT20  LGI  1         MCS4     4     246    25.3      25.3     100.0      0.0     100.0   0     0 0             1   1        
    HT20  LGI  1         MCS5     5     185    30.6      30.6     100.0      0.0     100.0   0     0 0             1   1        
    HT20  LGI  1         MCS6     6     164    32.9      32.9     100.0      0.0     100.0   0     0 0             1   1        
    HT20  LGI  1         MCS7     7     148    35.0      35.0      97.2      1.6     100.0   2     0 0           428   523      
    HT20  LGI  2         MCS8    10     739    10.5      10.5     100.0      0.0     100.0   4     0 0             1   1        
    HT20  LGI  2         MCS9    11     369    18.7      18.7     100.0      0.0     100.0   0     0 0             1   1        
    HT20  LGI  2         MCS10   12     246    25.3      25.3     100.0      0.0     100.0   0     0 0             1   1        
    HT20  LGI  2         MCS11   13     185    30.6      30.6     100.0      0.0     100.0   0     0 0             1   1        
    HT20  LGI  2         MCS12   14     123    38.9      38.9     100.0      0.0     100.0   6     0 0            10   10       
    HT20  LGI  2         MCS13   15      93    44.8      44.8      97.0      1.5     100.0   3     0 0            47   54       
    HT20  LGI  2     D   MCS14   16      82    47.3      47.3      98.0      1.7     100.0   2     0 0          2352   3185     
    HT20  LGI  2    C    MCS15   17      74    49.4      47.4      86.3      1.6     100.0   3     1 1         41363   50271    
    HT20  SGI  1         MCS0    30    1329     6.2       6.2     100.0      0.0     100.0   0     0 0             1   1        
    HT20  SGI  1         MCS1    31     665    11.5      11.5     100.0      0.0     100.0   0     0 0             1   1        
    HT20  SGI  1         MCS2    32     443    16.1      16.1      95.0      1.3     100.0   0     0 0            17   19       
    HT20  SGI  1         MCS3    33     332    20.2      20.2     100.0      0.0     100.0   0     0 0             1   1        
    HT20  SGI  1         MCS4    34     222    27.1      27.1     100.0      0.0     100.0   0     0 0             1   1        
    HT20  SGI  1         MCS5    35     166    32.8      32.8     100.0      0.0     100.0   0     0 0             1   1        
    HT20  SGI  1         MCS6    36     148    35.0      35.0     100.0      0.0     100.0   2     0 0            22   22       
    HT20  SGI  1      P  MCS7    37     133    37.2      37.2      97.3      1.6     100.0   6     0 0           423   519      
    HT20  SGI  2         MCS8    40     665    11.5      11.5     100.0      0.0     100.0   4     0 0             1   1        
    HT20  SGI  2         MCS9    41     332    20.2      20.2      97.1      1.5     100.0   0     0 0            26   29       
    HT20  SGI  2         MCS10   42     222    27.1      27.1      96.0      1.4     100.0   0     0 0            24   29       
    HT20  SGI  2         MCS11   43     166    32.8      32.8     100.0      0.0     100.0   0     0 0             1   1        
    HT20  SGI  2         MCS12   44     111    41.0      41.0      96.0      1.3     100.0   5     0 0           294   340      
    HT20  SGI  2         MCS13   45      83    46.9      46.9      98.1      1.8     100.0   3     0 0          7364   8527     
    HT20  SGI  2   B     MCS14   46      74    49.2      49.2      92.5      1.7     100.0   6     0 0         46910   56288    
    HT20  SGI  2  A      MCS15   47      67    51.4      51.4      99.6      0.8     100.0   6     1 1        272870   330742


Just for comparison the calculation of the TP in the table:

    tp_avg = minstrel_ht_get_tp_avg(mi, i, j, mrs->prob_ewma);

and the calculation of the TP in the minstrel_ht_get_expected_throughput:

    /* convert tp_avg from pkt per second in kbps */
    tp_avg = minstrel_ht_get_tp_avg(mi, i, j, prob) * AVG_PKT_SIZE * 8 / 1024;

Your original patch (cca674d47e59665630f3005291b61bb883015fc5) was
slightly different:

    return mi->groups[i].rates[j].cur_tp * AVG_PKT_SIZE * 8 / 1024;

I would guess that following commit mixed it up:

    6a27b2c40b48 ("mac80211: restructure per-rate throughput calculation into function")

It changed the code in debugfs to:

    -               tp = mrs->cur_tp / 10;
    +               tp_avg = minstrel_ht_get_tp_avg(mi, i, j);

But the code in the minstrel_ht_get_expected_throughput/minstrel_get_expected_throughput to

    -       /* convert cur_tp from pkt per second in kbps */
    -       return mi->groups[i].rates[j].cur_tp * AVG_PKT_SIZE * 8 / 1024;
    +       /* convert tp_avg from pkt per second in kbps */
    +       tp_avg = minstrel_ht_get_tp_avg(mi, i, j) * AVG_PKT_SIZE * 8 / 1024;

So there is at least a factor of 10 missing now (which perfectly matched with
the factor 10 Marek just removed in this patch).

Kind regards,
	Sven

[1] http://article.gmane.org/gmane.linux.kernel.wireless.general/148102

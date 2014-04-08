Return-Path: <johannes@sipsolutions.net>
Message-ID: <1396951400.5936.15.camel@jlt4.sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 08 Apr 2014 12:03:20 +0200
In-Reply-To: <1396211704-4677-2-git-send-email-antonio@meshcoding.com>
References: <1396211704-4677-1-git-send-email-antonio@meshcoding.com>
 <1396211704-4677-2-git-send-email-antonio@meshcoding.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [RFCv2 1/6] cfg80211: export expected throughput
 through get_station()
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: devel@lists.open80211s.org, b.a.t.m.a.n@lists.open-mesh.org, linux-wireless@vger.kernel.org, Antonio Quartulli <antonio@open-mesh.com>

On Sun, 2014-03-30 at 22:34 +0200, Antonio Quartulli wrote:

> -	STATION_INFO_INACTIVE_TIME	= 1<<0,

Since you're touching these all anyway, maybe convert to use BIT().


> @@ -1013,6 +1015,9 @@ struct sta_bss_parameters {
>   * @local_pm: local mesh STA power save mode
>   * @peer_pm: peer mesh STA power save mode
>   * @nonpeer_pm: non-peer mesh STA power save mode
> + * @expected_throughput: expected throughput as reported by the RC algorithm
> + *  about the bitrate having the maximum throughput. This field can be filled
> + *  only by drivers using Minstrel

This value needs a documented unit ... :)

johannes


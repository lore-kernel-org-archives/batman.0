Return-Path: <freifunk@irrelefant.net>
References: <20180506195559.32602-1-me@irrelefant.net>
 <2915136.3Ycz4JW85f@sven-edge> <1896302.CpHabpdRIs@sven-edge>
 <2913969.huEjgAY5Wz@sven-edge>
From: lemoer <freifunk@irrelefant.net>
Message-ID: <1da124b0-ea99-4d3a-3d55-fbaacd3754f7@irrelefant.net>
Date: Wed, 9 May 2018 23:34:18 +0200
MIME-Version: 1.0
In-Reply-To: <2913969.huEjgAY5Wz@sven-edge>
Content-Type: text/plain; charset="utf-8"
Content-Language: de-LU
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: prevent TT request storms by
 not sending inconsistent TT TLVLs
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

On 05/09/2018 10:38 PM, Sven Eckelmann wrote:
> Wait. When it is a problem of an intermediate node that doesn't have (for 
> whatever reason) not a valid copy of the entries, shouldn't the intermediate
> node just ignore the request and not answer it?

Yes. It's forwarded here

https://elixir.bootlin.com/linux/v4.16.8/source/net/batman-adv/translation-table.c#L4245

if the check here

https://elixir.bootlin.com/linux/v4.16.8/source/net/batman-adv/translation-table.c#L3199

fails. I also wrote a debug patch which adds counters which
differentiate between crc misses, ttvn misses and other misses. I can
also prepare them, when it is desired.

> And the next thing is that your commit message is talking about OGMs all the 
> time. But the OGM TVLV are not filled by the 
> batadv_tt_prepare_tvlv_global_data but by the 
> batadv_tt_prepare_tvlv_local_data. I am unable to find out what you actually
> doing here and why you do it.

Yes. IIRC the checksums in the OGMs are actually causing the issue. The
checksums in the TT responses are not evaluated for now.

Kind regards,
Leonardo Mörlein

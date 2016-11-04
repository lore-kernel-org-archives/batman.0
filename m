Return-Path: <johnzeng2013@yahoo.com>
Message-ID: <581C8E11.6000708@yahoo.com>
Date: Fri, 04 Nov 2016 21:33:05 +0800
From: johnzeng <johnzeng2013@yahoo.com>
MIME-Version: 1.0
Subject: Re: i have a question ?  How many relay nodes can be supported  at
 NetworkCoding ( mtu 1546 ) .
References: <581C7F4A.80104@yahoo.com>
In-Reply-To: <581C7F4A.80104@yahoo.com>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
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



Hello Dear Sir:

if anybody know the part , please give me some advisement .

Thanks
>
> Hello Dear Sir :
>
> i read some detail about NetworkCoding , my understanding :
>
> every relay node will detects neighbors packet at promisc mode and
> combine these packet into a single transmission ,
>
> and every relay mode will keep some usaful ( Ingoing: c8:3a:35:c9:ce:71
> .... ) and they will add some encoded information into packet
> ( will send destination )
>
> So we will run the part --- ip link set dev wlan0 mtu 1546 ( more than
> 1532 )
>
> but i have a question ? How many relay nodes can be supported at
> NetworkCoding ( mtu 1546 ) .
>
>
> Thanks
>
> Tiger
>
> batctl nn
> Node: c8:3a:35:c9:ce:71
> Ingoing: c8:3a:35:c9:ce:71
> Outgoing: c8:3a:35:c9:ce:71
>
> [root@alarmpi ~]# batctl nc
> enabled
>
>
> [root@alarmpi ~]# batctl statistics
> tx: 18
> tx_bytes: 2076
> tx_dropped: 32
> rx: 767
> rx_bytes: 33993
> forward: 0
> forward_bytes: 0
> mgmt_tx: 7956
> mgmt_tx_bytes: 542012
> mgmt_rx: 3132
> mgmt_rx_bytes: 222572
> frag_tx: 0
> frag_tx_bytes: 0
> frag_rx: 0
> frag_rx_bytes: 0
> frag_fwd: 0
> frag_fwd_bytes: 0
> tt_request_tx: 0
> tt_request_rx: 1
> tt_response_tx: 1
> tt_response_rx: 0
> tt_roam_adv_tx: 0
> tt_roam_adv_rx: 0
> dat_get_tx: 2
> dat_get_rx: 0
> dat_put_tx: 0
> dat_put_rx: 4
> dat_cached_reply_tx: 0
> nc_code: 0
> nc_code_bytes: 0
> nc_recode: 0
> nc_recode_bytes: 0
> nc_buffer: 17
> nc_decode: 0
> nc_decode_bytes: 0
> nc_decode_failed: 0
> nc_sniffed: 0


Return-Path: <dominicfollett@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKeC-QEtFkV1BnNMs+3ySNAnFo8R36t87sKATSJAjsqXZ1xXDg@mail.gmail.com>
References: <CA+h5Vgp5Pwjn0tVnC1bWg=R8tXdwxskesgtt2uTuwdSDtaNzDg@mail.gmail.com>
 <CAKeC-QEtFkV1BnNMs+3ySNAnFo8R36t87sKATSJAjsqXZ1xXDg@mail.gmail.com>
Date: Sun, 23 Sep 2012 00:37:41 +0200
Message-ID: <CA+h5VgrfqxUPw_oLNZT_odPF+f14eo59APBd4bjY=452XjU7Qg@mail.gmail.com>
From: Dominic Follett-Smith <dominicfollett@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] running batmand on Debian for Alix
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi Wayne,

thanks for the heads up, you were absolutely correct, I set the ssid
and the protocol is running successfully now - a 'rookie' error on my
part. Its still not associated with a cell, but for the current moment
I don't see any problems with it, that way.

Kind Regards
Dominic
UCT,SA

On Sat, Sep 22, 2012 at 6:37 PM, Wayne Abroue <plettpc@gmail.com> wrote:
> On Sat, Sep 22, 2012 at 6:06 PM, Dominic Follett-Smith
> <dominicfollett@gmail.com> wrote:
>> Hi,
>>
>> I am having trouble running the batman protocol on my debian distro
>> (2.6.32) on PC Engine's Alix boards. I am using CM9 pci cards, with
>> ath5k driver from the compat-wireless-3.5 package. I can scan for
>> networks, and view a survey dump using the iw tool. despite being able
>> to start the daemon successfully, neither node can receive packets
>> from one another. I set the mode to ad-hoc and channel to channel 7 on
>> both alix boards. The following url is a link to my system profile on
>> pastebin:
>>
>> http://pastebin.com/RtpTe31C
>>
>> it includes (ifconfig, iwconfig, interfaces configuration, sample of
>> running batman, dmesg for wireless interface wlan0 and modinfo for
>> ath5k )
>>
>> I can't figure out what I am doing wrong, I had perhaps naively
>> assumed that passing a configured wireless interface would be enough,
>> but I guess I have missed something important.
>>
>> Help is always greatly appreciated.
>>
>> Thanks
>> Dominic
>> UCT, SA
>
> Would it work without a ESSID and cell ID?
>
>
> wlan0     IEEE 802.11abg  ESSID:off/any
>           Mode:Ad-Hoc  Frequency:2.442 GHz  Cell: Not-Associated
>           Tx-Power=20 dBm
>           Retry  long limit:7   RTS thr:off   Fragment thr:off
>           Encryption key:off
>           Power Management:off
>
> Wayne



-- 
If you are going to achieve excellence in big things, you develop the
habit in little matters. Excellence is not an exception, it is a
prevailing attitude.
Colin Powell

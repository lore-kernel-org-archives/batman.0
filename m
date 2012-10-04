Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <CAHD-aq+BO6JZtojFHNgZ+pyHd_9nLviTUi9+xbenpFwyaPM3jw@mail.gmail.com>
References: <CA+h5VgqB82br1u9Cdg423Eedd8m23wMO=PWo86q+TTAXVtuy8Q@mail.gmail.com>
 <CAHD-aq+Uy6jOEbxmE8Tymu5wTsVMaVtDSOdWEJ0BujAVe2s3Dw@mail.gmail.com>
 <CA+h5VgobQQZWN+Vr_+UbQaxLw6qV=G6C0XYGLvHA+88QRzGQwQ@mail.gmail.com>
 <CAHD-aq+BO6JZtojFHNgZ+pyHd_9nLviTUi9+xbenpFwyaPM3jw@mail.gmail.com>
Date: Thu, 4 Oct 2012 18:11:47 -0300
Message-ID: <CAHD-aqL_CmM3gsNPeMCdcuwDpXSnXXPP2Ho4_pkzt9HKL02wKg@mail.gmail.com>
From: Gui Iribarren <gui@altermundi.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] Fwd:  mac address from packet
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

---------- Forwarded message ----------
From: Gui Iribarren <gui@altermundi.net>
Date: Thu, 4 Oct 2012 16:46:30 -0300
Subject: Re: [B.A.T.M.A.N.] mac address from packet
To: Dominic Follett-Smith <dominicfollett@gmail.com>

Add a wireless interface in monitor mode, and start a wireshark/tcpdump on =
that.

If the driver and chipset are cooperative enough, The first header
will contain the signal, noise, bssid and phy mac src/dst, etc for
*each* packet. Look for ogm packets and voil=C3=A0.

Ogms are no different from any other data packet on this layer.
So this went way offtopic for this list. You should inform yourself
(elsewhere :) ) about the validity of those rssi/noise numbers, for
your particular chipset & driver.

On 10/4/12, Dominic Follett-Smith <dominicfollett@gmail.com> wrote:
> Thanks,
>
> Sven says that , "The mac is part of the ethernet mac header at the
> beginning of
> the frame." But I still don't know how to access this.
>
> We are trying to get the received signal strength from the OGM we have
> received, in order to do interference calculations.
>
> Kind Regards
> Dominic
>
>
>
> On Thu, Oct 4, 2012 at 6:38 PM, Gui Iribarren <gui@altermundi.net> wrote:
>> AFAIU batman is unaware of the PHY layer mac address, so your only
>> option is sniffing that out of a pcap dump.
>>
>> Or, i misundestood your objective. Can you explain a little bit more
>> what you're trying to do?
>>
>> On 10/4/12, Dominic Follett-Smith <dominicfollett@gmail.com> wrote:
>>> Hi,
>>>
>>> is there a way to get the mac address of the station that sent the
>>> bat_packet?
>>> We want to get hold of parameters such as signal strength. We could do
>>> this by using the radiotap header, or by looking at the iw station
>>> dump of a neighbour. The second option requires the use of the mac
>>> address.
>>>
>>> Regards
>>> Dominic
>>> UCT, SA
>>>
>>> --
>>> If you are going to achieve excellence in big things, you develop the
>>> habit in little matters. Excellence is not an exception, it is a
>>> prevailing attitude.
>>> Colin Powell
>>>
>
>
>
> --
> If you are going to achieve excellence in big things, you develop the
> habit in little matters. Excellence is not an exception, it is a
> prevailing attitude.
> Colin Powell
>

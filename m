Return-Path: <rgibson@futurec.net>
Message-ID: <50E9FAD0.8000004@futurec.net>
Date: Sun, 06 Jan 2013 14:29:36 -0800
From: Ray Gibson <rgibson@futurec.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] wpa-none through openwrt config
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

Hello,

I'm trying to get wpa-none happy on my bullet m5's running batman-adv 
(aa-rc1 with batman-adv 2012.3.0).  I can make it work by running 
wpa_supplicant manually with the correct options but am interested in 
having it work through the uci config files.  Is this possible?  The 
wpa_supplicant.sh script seems to want to force wpa-psk with any options 
that force wpa_supplicant, which generate a relatively useless 
supplicant config file for ibss. This also makes wlan0 get the default 
1500 MTU.

Here's my "semi-working" wpa_supplicant.conf file, after I increase the 
MTU then batman talks properly and sees the other node.  semi-working 
because even though batctl o sees the other node it can't ping it unless 
the psk is commented out.. :-\

ctrl_interface=/var/run/wpa_supplicant
ctrl_interface_group=0
eapol_version=1
ap_scan=2
fast_reauth=1
#IBSS/ad-hoc mode with WPA2/AES encryption
network={
     ssid="batmesh"
     bssid=20:aa:bb:cc:dd:ee
     mode=1
     scan_ssid=1
     frequency=5765
     fixed_freq=1
     mcast_rate=18
     htmode=HT20
     proto=WPA
     key_mgmt=WPA-NONE
     pairwise=NONE
     group=CCMP
     psk="xxxxxxxx"
}

Thanks for any ideas.

-- 
Ray Gibson
Future Concepts IS Inc.
909-593-6705 x2096




This communication constitutes an electronic communication within the meaning of the Electronic Communications Privacy Act, 18 USC 2510, and its disclosure is strictly limited to the recipient intended by the sender of this message. This e-mail and any files transmitted with it are proprietary and intended for the sole use of the individual or entity to whom they are addressed. They are not to be viewed, shared, copied or forwarded, regardless to whom, without the expressed permission of Future Concepts I.S., Inc. If you have received this e-mail in error, please notify the sender and immediately delete it from your system. Thank you.


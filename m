Return-Path: <saurabh.chakrabarti@amideeptech.com>
Message-ID: <5358CC9E.3040506@amideeptech.com>
Date: Thu, 24 Apr 2014 14:04:38 +0530
From: Saurabh Chakrabarti <saurabh.chakrabarti@amideeptech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] MTU issue
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

Following the Troubleshooting guide, I have changed the MTU for bat0 
interface to 1524. I'm getting this message in my syslog:

Jan  1 00:00:53 localhost kernel: [   26.899762] batman_adv: bat0: The 
MTU of interface wlan0 is too small (1524) to handle the transport of 
batman-adv packets. Packets going over this interface will be fragmented 
on layer2 which could impact the performance. Setting the MTU to 1560 
would solve the problem.

I'm not seeing any apparent performance issues, but do I really need to 
make the MTU 1560?

-saurabh

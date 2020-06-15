Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Rob Cowart <rob.cowart@xecoenergy.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: batadv gw_mode client 0?
Message-Id: <927533E5-C265-44BF-B271-1A7A9A084447@xecoenergy.com>
Date: Mon, 15 Jun 2020 15:45:34 -0500
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,

  We've been using batman with alfred and MQTT on raspbian for about 3 =
years.  We found it to be useful up to about 15 nodes, and then we'd =
saturate the wifi.  Then we downgraded the driver and we can get =
slightly over 30.  but something we found was all of our nodes were =
using gw_mode client 0, and we realized this isn't listed in the spec.  =
Do you know what it does in that case, does it use the default of 20?

Thanks,
Rov
